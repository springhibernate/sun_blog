module UserInfosHelper
  def status_text(status)
    rlt=''
    if status==1
      rlt=t 'valid'
    else
      rlt=t 'invalid'
    end
    return rlt
  end

  def lif(datetime_obj)
    if not datetime_obj
      return ''
    else
      return l datetime_obj
    end
  end
end
