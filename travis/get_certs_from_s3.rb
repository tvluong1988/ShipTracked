require 'aws-sdk'

s3 = Aws::S3::Resource.new(region: $AWS_DEFAULT_REGION)

iosDeveloper = s3.bucket('bucket-ios-certs').object('iosDeveloper.p12.enc')
iosDeveloper.get(response_target: './iosDeveloper.p12.enc')

iosDistribution = s3.bucket('bucket-ios-certs').object('iosDistribution.p12.enc')
iosDistribution.get(response_target: './iosDistribution.p12.enc')