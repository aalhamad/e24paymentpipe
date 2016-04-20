namespace :parse do
  desc "Parse resource.cgn"
  task :e24_secure, [:alias] => :environment do |t, args|
    parsed_secure_settings = E24PaymentPipe::SecureSettings.new(alias: args[:alias]).secure_data
    parsed_secure_settings.each do |k, v|
      puts "#{k}: #{v}"
    end
  end
end
