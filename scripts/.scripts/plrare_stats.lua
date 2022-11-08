#!/usr/bin/env lua
-- Used by the plrare script to compute and display statistics based on
-- playcount data read from standard input.

MUSIC_DIR = os.getenv('HOME')..'/Music/'
CACHE_DIR = os.getenv('XDG_CACHE_HOME')..'/' or (os.getenv('HOME')..'/.cache/')
CACHE_FILE = CACHE_DIR..'plrare-stats-cache.tsv'
CACHE_WRITE_THRES = 100
TOP_N = 10 -- how many top listened artists/albums to display
cache_change_counter = 0
skipped = {}

-- Make sure the file exists
io.close(io.open(CACHE_FILE, 'a'))

function bump_cache_counter()
	cache_change_counter = cache_change_counter + 1
	if cache_change_counter >= CACHE_WRITE_THRES then
		write_cache()
		cache_change_counter = 0
	end
end

function build_cache()
	cache = {}
	cache_list = {}
	local ARG_MAX = 100 -- we don't want to run a command with an absurd number of arguments
	local stat_batch = {}

	function process_batch(i_start)
		local cmd = "stat -c %Y -- "..table.concat(stat_batch, ' ')
		stat_batch = {}
		local i, cmd_output = i_start, assert(io.popen(cmd, 'r'))
		for line in cmd_output:lines() do
			local item = cache_list[i]
			local last_modified = tonumber(line)
			if last_modified <= item.timestamp then
				cache[item.fname] = item.duration
			else
				table.remove(cache_list, i)
				i = i - 1
				bump_cache_counter()
			end
			i = i + 1
		end
		cmd_output:close()
		return i
	end

	local next_batch_i = 1
	for line in io.lines(CACHE_FILE) do
		local f = line:gmatch('[^\t]*')
		local timestamp, duration, file = tonumber(f()), tonumber(f()), f()
		f = io.open(MUSIC_DIR..file, 'r')
		if f == nil then
			goto continue
		end
		f:close()
		cache_list[#cache_list + 1] = {fname=file, duration=duration, timestamp=timestamp}
		stat_batch[#stat_batch + 1] = " '"..MUSIC_DIR..file:gsub("'", "'\"'\"'").."'"
		if #stat_batch >= ARG_MAX then
			next_batch_i = process_batch(next_batch_i)
		end
		::continue::
	end
	if #stat_batch > 0 then
		next_batch_i = process_batch(next_batch_i)
	end
	assert(next_batch_i == #cache_list + 1)
end

function get_duration(file)
	if cache[file] == nil then
		local cmd = assert(io.popen("mp3info -p %S -- '"..MUSIC_DIR..file:gsub("'", "'\"'\"'").."'", 'r'))
		local duration = tonumber(assert(cmd:read('*a')))
		cmd:close()
		cache_list[#cache_list + 1] = {fname=file, duration=duration, timestamp=os.time()}
		cache[file] = duration
		bump_cache_counter()
	end
	return cache[file]
end

function parse_input()
	local data = {}
	for line in io.stdin:lines() do
		local f = line:gmatch('[^\t]*')
		local count, file = tonumber(f()), f()
		f = io.open(MUSIC_DIR..file, 'r')
		if f ~= nil then
			f:close()
			data[#data + 1] = {fname=file, count=count}
		else
			skipped[#skipped + 1] = file
		end
	end

	local no_seconds = 0
	local no_tracks = #data
	local no_artists = 0
	local no_albums = 0
	local no_plays = 0
	local artists = {}
	local albums = {}
	for i, item in ipairs(data) do
		io.write(string.format('\rReading %d/%d %.2f%%... (%dh)',
			i, #data, i / #data * 100, no_seconds // 3600))
		local duration = get_duration(item.fname)
		local artist = item.fname:match('^[^/]*')
		local album = item.fname:match('^[^/]*/([^/]*)/')
		if albums[album] == nil then
			albums[album] = duration
			no_albums = no_albums + 1
		else
			albums[album] = albums[album] + duration
		end
		if artists[artist] == nil then
			artists[artist] = duration
			no_artists = no_artists + 1
		else
			artists[artist] = artists[artist] + duration
		end
		no_plays = no_plays + item.count
		no_seconds = no_seconds + (item.count * duration)
	end
	print(' done.')

	local d = no_seconds // 86400
	local h = (no_seconds % 86400) // 3600
	local m = (no_seconds % 3600) // 60
	local s = no_seconds % 60
	print(string.format('Total listen time:   %dd, %dh, %dm, %ds', d, h, m, s))
	print(string.format('Total no. plays:     %d', no_plays))
	print()
	print(string.format('No. tracks:          %d', no_tracks))
	print(string.format('Avg track duration:  %02d:%02d',
		no_seconds // no_plays // 60, no_seconds // no_plays % 60))
	print()
	print(string.format('No. artists:         %d', no_artists))
	print('Top listened artists:')
	artists['Various Artists'] = nil
	local artists_list = {}
	for k, v in pairs(artists) do
		artists_list[#artists_list + 1] = {
			string.format('  %02d:%02d:%02d',
				v // 3600,
				v % 3600 // 60,
				v % 60),
			k
		}
	end
	table.sort(artists_list, function(x, y) return x[1] > y[1] end)
	for i = 1, math.min(TOP_N, #artists_list) do
		print(artists_list[i][1], artists_list[i][2])
	end
	print()
	print(string.format('No. albums:          %d', no_albums))
	print('Top listened albums:')
	albums['no album'] = nil
	local albums_list = {}
	for k, v in pairs(albums) do
		albums_list[#albums_list + 1] = {
			string.format('  %02d:%02d:%02d',
				v // 3600,
				v % 3600 // 60,
				v % 60),
			k
		}
	end
	table.sort(albums_list, function(x, y) return x[1] > y[1] end)
	for i = 1, math.min(TOP_N, #albums_list) do
		print(albums_list[i][1], albums_list[i][2])
	end
end

function write_cache()
	local f = io.open(CACHE_FILE, 'w')
	for _, item in ipairs(cache_list) do
		f:write(item.timestamp, '\t', item.duration, '\t', item.fname, '\n')
	end
	f:close()
end

build_cache()
parse_input()
if cache_change_counter ~= 0 then
	write_cache()
end
if #skipped > 0 then
	print('\nSkipped these invalid paths:')
	for _, v in ipairs(skipped) do
		print('', v)
	end
end
