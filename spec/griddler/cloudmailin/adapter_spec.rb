require 'spec_helper'

describe Griddler::Cloudmailin::Adapter, '.normalize_params' do
  it_should_behave_like 'Griddler adapter', :cloudmailin, {
    envelope: {
      to: 'Hello World <hi@example.com>',
      from: 'There <there@example.com>',
    },
    plain: 'hi',
    headers: { Cc: 'emily@example.com' },
  }

  it 'normalizes parameters' do
    expect(Griddler::Cloudmailin::Adapter.normalize_params(default_params)).to be_normalized_to({
      to: ['Some Identifier <some-identifier@example.com>'],
      cc: ['emily@example.com'],
      from: 'Joe User <joeuser@example.com>',
      subject: 'Re: [ThisApp] That thing',
      text: /Dear bob/,
      headers: { Subject: 'Re: [ThisApp] That thing', Cc: 'emily@example.com' }
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
      envelope: { to: 'Some Identifier <some-identifier@example.com>', from: 'Joe User <joeuser@example.com>' },
      headers: { Subject: 'Re: [ThisApp] That thing', Cc: 'emily@example.com' },
      plain: <<-EOS.strip_heredoc.strip
        Dear bob

        Reply ABOVE THIS LINE

        hey sup
      EOS
    }
  end
end
