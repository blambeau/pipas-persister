module PipasPersister
  module Service
    class Facade < Base

      README = PipasPersister::ROOT_FOLDER/"README.md"

      get '/' do
        intro = Kramdown::Document.new(README.read).to_html
        wlang :index, locals: {intro: intro}
      end

    end # class Facade
  end # module Service
end # module PipasPersister
