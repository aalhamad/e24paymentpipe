module E24PaymentPipe
  class Railtie < Rails::Railtie
    railtie_name :parse

    rake_tasks do
      load "tasks/parse.rake"
    end
  end
end
