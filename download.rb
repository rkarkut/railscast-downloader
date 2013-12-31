require 'net/http'
require 'open-uri'
require 'rubygems'
require 'xmlsimple'

def downloadFile name, url, type

    p "downloading file: #{url}"

    begin
        File.open("videos/#{name}.#{type}", "wb") do |saved_file|

            open(url, "rb") do |read_file|
            saved_file.write(read_file.read)

            p "done..."
            end
        end

    rescue

        p "file #{url} not found"
    end
end

data = XmlSimple.xml_in('railscasts.xml')

data['channel'].each do |channel|
    
    count = 0

    channel['item'].each do |el|

        count += 1
    end

    num = 0

    channel['item'].each do |el|

        p "downloading file #{num}/#{count}"

        num += 1

        name    = el['title'][0]
        url     = el['enclosure'][0]['url']
        type    = el['enclosure'][0]['type']

        if type == 'video/mp4'
            type = 'mp4'
        else
            print "incorrect type: #{type}"
        end

        downloadFile name, url, type

    end
end