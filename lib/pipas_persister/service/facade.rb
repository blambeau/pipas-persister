module PipasPersister
  module Service
    class Facade < Base

      README = PipasPersister::ROOT_FOLDER/"README.md"

      CHANGELOG = PipasPersister::ROOT_FOLDER/"CHANGELOG.md"

      get '/' do
        intro = Kramdown::Document.new(README.read).to_html
        wlang :index, locals: {intro: intro}
      end

      get '/doc/changelog' do
        intro = Kramdown::Document.new(CHANGELOG.read).to_html
        wlang :index, locals: {intro: intro}
      end

    end # class Facade
  end # module Service
end # module PipasPersister
