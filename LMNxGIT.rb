#!/usr/bin/env ruby
'''
 </> ---------------------------------------------
 </> Released By : DARK TEAM LMNx9
 </> ---------------------------------------------
 </> coded by -> Limon Hossain
 </> Project -> LMNxGIT v1.0
 </> Updated On -> 19 October 2025
 </> Channel -> t.me/TM_LMNx9
 </> GitHub -> github.com/LMNx9-JOHNY
 </> ---------------------------------------------
 </> Note : Fuxk You Kids | We Don’t Sacrifice..!
 </> ---------------------------------------------
'''

require 'net/http'
require 'uri'
require 'fileutils'
require 'json'

begin
    require 'colorize'
rescue LoadError
    puts "Installing colorize gem..."
    system("gem install colorize -q --no-document")
    Gem.clear_paths
    require 'colorize'
end

begin
    FileUtils.mkdir_p("/sdcard/LMNxGIT-Download")
rescue
end

def lmnXsukhi_line
    puts "───────────────────────────────────────────────".white.bold
end

def dark_lmnx9_main
    system("clear")
    puts """
  ▗▖   ▗▖  ▗▖▗▖  ▗▖ ▄   ▄  ▗▄▄▖▗▄▄▄▖▗▄▄▄▖
  ▐▌   ▐▛▚▞▜▌▐▛▚▖▐▌  ▀▄▀  ▐▌     █    █
  ▐▌   ▐▌  ▐▌▐▌ ▝▜▌ ▄▀ ▀▄ ▐▌▝▜▌  █    █
  ▐▙▄▄▖▐▌  ▐▌▐▌  ▐▌       ▝▚▄▞▘▗▄█▄▖  █  v1.0 """.green.bold
    lmnXsukhi_line
    puts " GITHUB MULTI-BRANCH REPOSITORY DOWNLOADER ".magenta.bold
    puts " Developer - DARK LMNx9 | t.me/TM_LMNx9".green.bold
    lmnXsukhi_line
    print " ->> URL -> "
    lmnXsukhi_url = gets.strip
    lmnXsukhi_line
    lmnXsukhi_git_main(lmnXsukhi_url)
end

def lmnXsukhi_get_branch(lmnXsukhi_u, lmnXsukhi_r)
    begin
        lmnXsukhi_api = "https://api.github.com/repos/#{lmnXsukhi_u}/#{lmnXsukhi_r}/branches"
        lmnXsukhi_uri = URI(lmnXsukhi_api)
        lmnXsukhi_res = Net::HTTP.get_response(lmnXsukhi_uri)
        if lmnXsukhi_res.code == '200'
            lmnXsukhi_data = JSON.parse(lmnXsukhi_res.body)
            return lmnXsukhi_data.map { |b| b['name'] }
        else
            return ["main", "master"]
        end
    rescue
        return ["main", "master"]
    end
end

def lmnXsukhi_show_files(lmnXsukhi_u, lmnXsukhi_r, lmnXsukhi_b)
    begin
        lmnXsukhi_api = "https://api.github.com/repos/#{lmnXsukhi_u}/#{lmnXsukhi_r}/git/trees/#{lmnXsukhi_b}?recursive=1"
        lmnXsukhi_uri = URI(lmnXsukhi_api)
        lmnXsukhi_res = Net::HTTP.get_response(lmnXsukhi_uri)
        if lmnXsukhi_res.code == '200'
            lmnXsukhi_data = JSON.parse(lmnXsukhi_res.body)
            lmnXsukhi_files = lmnXsukhi_data['tree'].select { |i| i['type'] == 'blob' }.map { |i| i['path'] }
            lmnXsukhi_folders = lmnXsukhi_data['tree'].select { |i| i['type'] == 'tree' }.map { |i| i['path'] }
            if lmnXsukhi_folders.any?
                puts " ->> LMNxGIT Folders ->".magenta.bold
                lmnXsukhi_folders[0..9].each { |f| puts " 📁 #{f}".cyan.bold }
                puts " ... and #{(lmnXsukhi_folders.length - 10).to_s.green.bold} more Folders" if lmnXsukhi_folders.length > 10
            end
            if lmnXsukhi_files.any?
                puts " ->> LMNxGIT Files ->".magenta.bold
                lmnXsukhi_files[0..9].each { |f| puts " 📄 #{f}".green.bold }
                puts " ... and #{(lmnXsukhi_files.length - 10).to_s.green.bold} more Files" if lmnXsukhi_files.length > 10
            end
            lmnXsukhi_line
        end
    rescue
    end
end

def lmnXsukhi_down_zip(lmnXsukhi_url, lmnXsukhi_path)
    begin
        lmnXsukhi_uri = URI(lmnXsukhi_url)
        lmnXsukhi_http = Net::HTTP.new(lmnXsukhi_uri.host, lmnXsukhi_uri.port)
        lmnXsukhi_http.use_ssl = true
        lmnXsukhi_req = Net::HTTP::Get.new(lmnXsukhi_uri.request_uri)
        lmnXsukhi_req['User-Agent'] = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36'

        lmnXsukhi_http.request(lmnXsukhi_req) do |lmnXsukhi_res|
            if lmnXsukhi_res.is_a?(Net::HTTPRedirection)
                redirected_url = lmnXsukhi_res['location']
                return lmnXsukhi_down_zip(redirected_url, lmnXsukhi_path)
            end

            lmnXsukhi_total = lmnXsukhi_res['content-length'].to_i
            lmnXsukhi_down = 0
            File.open(lmnXsukhi_path, 'wb') do |lmnXsukhi_f|
                lmnXsukhi_res.read_body do |lmnXsukhi_chunk|
                    lmnXsukhi_f.write(lmnXsukhi_chunk)
                    lmnXsukhi_down += lmnXsukhi_chunk.length
                    lmnXsukhi_pct = ((lmnXsukhi_down.to_f / lmnXsukhi_total) * 100).round(2)
                    print "\r ->> LMNxGIT -> #{File.basename(lmnXsukhi_path)} [#{lmnXsukhi_pct}%]"
                end
            end
        end

        puts "\n"
        return File.absolute_path(lmnXsukhi_path)
    rescue => lmnXsukhi_e
        puts " ->> LMNxGIT Download Failed -> #{lmnXsukhi_e}".red.bold
        lmnXsukhi_line
        print " ->> Press Enter To Back Main -> "
        gets
        dark_lmnx9_main
    end
end

def lmnXsukhi_git_main(lmnXsukhi_url)
    begin
        lmnXsukhi_url = lmnXsukhi_url[0..-2] if lmnXsukhi_url.end_with?('/')
        lmnXsukhi_parts = lmnXsukhi_url.split('/')
        if lmnXsukhi_parts.length < 5
            puts " ->> Invalid GitHub Repository Link...".red.bold
            lmnXsukhi_line
            print " ->> Press Enter To Back Main -> "
            gets
            return dark_lmnx9_main
        end

        lmnXsukhi_u = lmnXsukhi_parts[3]
        lmnXsukhi_r = lmnXsukhi_parts[4]
        lmnXsukhi_r = lmnXsukhi_r[0..-5] if lmnXsukhi_r.end_with?('.git')

        puts " ->> Checking Repository -> ".magenta.bold + "#{lmnXsukhi_u}/#{lmnXsukhi_r}".cyan.bold
        lmnXsukhi_branches = lmnXsukhi_get_branch(lmnXsukhi_u, lmnXsukhi_r)
        lmnXsukhi_line
        lmnXsukhi_down_count = 0

        lmnXsukhi_branches.each do |lmnXsukhi_b|
            lmnXsukhi_zip_url = "https://github.com/#{lmnXsukhi_u}/#{lmnXsukhi_r}/archive/refs/heads/#{lmnXsukhi_b}.zip"
            lmnXsukhi_check_url = "https://api.github.com/repos/#{lmnXsukhi_u}/#{lmnXsukhi_r}/branches/#{lmnXsukhi_b}"
            lmnXsukhi_check_uri = URI(lmnXsukhi_check_url)
            lmnXsukhi_check_res = Net::HTTP.get_response(lmnXsukhi_check_uri)
            next if lmnXsukhi_check_res.code != '200'

            lmnXsukhi_show_files(lmnXsukhi_u, lmnXsukhi_r, lmnXsukhi_b)
            lmnXsukhi_zip_name = "/sdcard/LMNxGIT-Download/#{lmnXsukhi_r}_#{lmnXsukhi_b}.zip"

            puts " ->> Downloading Repository -> ".cyan.bold + "#{lmnXsukhi_r} -> #{lmnXsukhi_b}".green.bold
            lmnXsukhi_line
            lmnXsukhi_file = lmnXsukhi_down_zip(lmnXsukhi_zip_url, lmnXsukhi_zip_name)

            if lmnXsukhi_file
                lmnXsukhi_line
                puts " ->> Saved -> ".green.bold + "#{lmnXsukhi_file}".magenta.bold
                lmnXsukhi_down_count += 1
            end
            lmnXsukhi_line
        end

        if lmnXsukhi_down_count > 0
            puts " ->> #{lmnXsukhi_down_count} Branches Downloaded Successfully".green.bold
        else
            puts " ->> Invalid Repository ! Download Failed".red.bold
        end

        lmnXsukhi_line
        print " ->> Press Enter To Back Main -> "
        gets
        dark_lmnx9_main
    rescue => lmnXsukhi_e
        lmnXsukhi_line
        puts " ->> LMNxGIT Download Error -> #{lmnXsukhi_e}".red.bold
        lmnXsukhi_line
        print " ->> Press Enter To Back Main -> "
        gets
        dark_lmnx9_main
    end
end

dark_lmnx9_main
