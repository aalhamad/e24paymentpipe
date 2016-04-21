namespace :parse do
  desc "Parse resource.cgn"
  task :e24_secure, [:alias, :path] => :environment do |t, args|
    path = File.dirname(args[:path])
    filename = File.basename(args[:path])

    puts E24PaymentPipe::SecureSettings.new(
      alias: args[:alias],
      resource_path: "#{path}/",
      input_file_name: filename,
      output_file_name: "#{filename}.zip"
    ).secure_data
  end
end
