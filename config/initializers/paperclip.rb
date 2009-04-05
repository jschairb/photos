# image_magick_path= `/usr/bin/which identify`.strip.chomp("/identify")
image_magick_path = "/opt/local/bin"
Paperclip.options[:command_path] = image_magick_path
