class VideoProcessorJob < ApplicationJob

  queue_as :default

  def perform
    # Do something later

    ## aca incluir run encoder 

	puts "Encoder.entre"
    
    #lst_videos = Video.where(status is not true)

    # Convertir cada video en la lista

    Video.where(status: false).find_each do |video|

	    #video = Video.find(video_id)

		#if video.encoded?
		#	break
		#end

	    path = video.link_original.path
	    output =  path + "#{Time.now.getutc.to_f.to_s.delete('.')}.mp4"

	    _command = `./bin/ffmpeg -i #{path} -f mp4 -vcodec mpeg4 -acodec aac -strict -2 #{output}`
	 
		if $?.to_i == 0
			video.process!
		else
			raise $?
		end

    end 
  end

end
