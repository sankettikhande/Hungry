class CitrusLib

  def setApiKey (key,env)
    @@apiKey = key
    @@env = env

    case @@env
      when 'sandbox'
        @@apiUrl = @@SANDBOX_API_URL
        @@cpUrl = @@SANDBOX_PMT_URL
      when 'staging'
        @@apiUrl = @@STAGING_API_URL
        @@cpUrl = @@STAGING_PMT_URL
      when 'production'
        @@apiUrl = @@PRODUCTION_API_URL
        @@cpUrl = @@PRODUCTION_PMT_URL
    end

  end

  def getApiUrl()
    return @@apiUrl
  end

  def getCpUrl()
    return @@cpUrl
  end

  def getHmac(data)
    digest = OpenSSL::Digest::Digest.new('sha1')
    sig=OpenSSL::HMAC.hexdigest(digest, @@apiKey, data)
    return sig
  end

  @@SANDBOX_API_URL='https://sandboxadmin.citruspay.com/api/v1/txn/'
  @@SANDBOX_PMT_URL='https://sandbox.citruspay.com/'

  @@STAGING_API_URL='https://stgadmin.citruspay.com/api/v1/txn/'
  @@STAGING_PMT_URL='https://stg.citruspay.com/'

  @@PRODUCTION_API_URL='https://admin.citruspay.com/api/v1/txn/'
  @@PRODUCTION_PMT_URL='https://www.citruspay.com/'

  @@apiKey=''
  @@env=''
  @@apiUrl=''
  @@cpUrl=''

end