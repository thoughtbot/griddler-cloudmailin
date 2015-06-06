require 'spec_helper'

describe Griddler::Cloudmailin::Adapter, '.normalize_params' do
  context 'without bcc' do
    it_should_behave_like 'Griddler adapter', :cloudmailin, {
      envelope: {
        to: 'hi@example.com',
        from: 'there@example.com',
      },
      plain: 'hi',
      headers: {
        From: 'there@example.com',
        To: 'Hello World <hi@example.com>',
        Cc: 'emily@example.com'
      },
    }
  end

  context 'with bcc' do
    it_should_behave_like 'Griddler adapter', :cloudmailin, {
      envelope: {
        to: 'sandra@example.com',
        from: 'there@example.com',
      },
      plain: 'hi',
      headers: {
        From: 'there@example.com',
        To: 'Hello World <hi@example.com>',
        Cc: 'emily@example.com'
      },
    }
  end

  it 'normalizes parameters' do
    expect(Griddler::Cloudmailin::Adapter.normalize_params(default_params)).to be_normalized_to({
      to: ['Some Identifier <some-identifier@example.com>'],
      cc: ['emily@example.com'],
      from: 'Joe User <joeuser@example.com>',
      subject: 'Re: [ThisApp] That thing',
      text: /Dear bob/
    })
  end

  it 'normalizes parameters where the recipient has been BCCed' do
    expect(Griddler::Cloudmailin::Adapter.normalize_params(bcc_params)).to be_normalized_to({
      to: ['Some Identifier <some-identifier@example.com>'],
      cc: ['emily@example.com'],
      bcc: ['sandra@example.com'],
      from: 'Joe User <joeuser@example.com>',
      subject: 'Re: [ThisApp] That thing',
      text: /Dear bob/
    })
  end

  it 'passes the received array of files' do
    params = default_params.merge({ attachments: [upload_1, upload_2] })

    normalized_params = Griddler::Cloudmailin::Adapter.normalize_params(params)
    expect(normalized_params[:attachments]).to eq [upload_1, upload_2]
  end

  it 'has no attachments' do
    params = default_params

    normalized_params = Griddler::Cloudmailin::Adapter.normalize_params(params)
    expect(normalized_params[:attachments]).to be_empty
  end

  def default_params
    {
      envelope: { to: 'some-identifier@example.com', from: 'joeuser@example.com' },
      headers: {
        Subject: 'Re: [ThisApp] That thing',
        From: 'Joe User <joeuser@example.com>',
        To: 'Some Identifier <some-identifier@example.com>',
        Cc: 'emily@example.com'
      },
      plain: <<-EOS.strip_heredoc.strip
        Dear bob

        Reply ABOVE THIS LINE

        hey sup
      EOS
    }
  end

  def bcc_params
    p = default_params
    p[:envelope][:to] = 'sandra@example.com'
    p
  end
end
