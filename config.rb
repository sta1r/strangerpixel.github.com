# Require any additional compass plugins here.
#require 'ruby-growl'

# Set this to the root of your project when deployed:
http_path = "http://localhost:4000/"
css_dir = "css/"
sass_dir = "lib/"
javascripts_dir = "js"
images_dir = "img/"

# on_sprite_saved do |filename|
 
#   unless filename.match(/^transparent/)
 
#     png8filename = filename.sub(/\.png/, '-fs8.png')
#     %x{compile/pngquant/pngquant #{filename}}
#     %x{mv -f #{png8filename} #{filename}}
 
#   end
 
#   g = Growl.new "localhost", "ruby-growl",
#     ["ruby-growl Notification"]
#   g.notify "ruby-growl Notification", "Compass sprite generation",
#     "Your sprite is done:" + filename 
 
# end

# You can select your preferred output style here (can be overridden via the command line):
# output_style = :expanded or :nested or :compact or :compressed
output_style = :compressed

# To enable relative paths to assets via compass helper functions. Uncomment:
#relative_assets = true

http_images_path = "http://localhost:4000/img"
# To disable debugging comments that display the original location of your selectors. Uncomment:
line_comments = false


# If you prefer the indented syntax, you might want to regenerate this
# project again passing --syntax sass, or you can uncomment this:
# preferred_syntax = :sass
# and then run:
# sass-convert -R --from scss --to sass sass scss && rm -rf sass && mv scss sass

