class ColorController < ApplicationController
  VARIABLES = ['@bodyBackground', '@navbarBackground', '@textColor',
               '@linkColor', '@linkColorHover']

  def index
  end

  def compile_less
    hex_codes = (params[:colors] || '').split(',').select do |hex_code|
      hex_code =~ /^([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})$/
    end
    path = File.join(Rails.root, 'vendor', 'assets', 'stylesheets')
    parser = Less::Parser.new(paths: [path])
    less = File.read(File.join(path, 'variables.less'))
    index = 0
    VARIABLES.each do |variable|
      break if index >= hex_codes.length
      less += "#{variable}: ##{hex_codes[index]};\n"
      index += 1
    end
    less += File.read(File.join(path, 'bootstrap.less'))
    render text: parser.parse(less).to_css, content_type: 'text/css'
  end
end
