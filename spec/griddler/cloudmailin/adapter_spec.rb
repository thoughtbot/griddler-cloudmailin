require 'spec_helper'

describe Griddler::Cloudmailin::Adapter do
  it 'registers itself with griddler' do
    expect(Griddler.adapter_registry[:cloudmailin]).to be(
      Griddler::Cloudmailin::Adapter
    )
  end
end

describe Griddler::Cloudmailin::Adapter, '.normalize_params' do
  context 'without bcc' do
    it_should_behave_like(
      'Griddler adapter',
      :cloudmailin,
      envelope: {
        to: 'hi@example.com',
        from: 'there@example.com'
      },
      plain: 'hi',
      headers: {
        From: 'there@example.com',
        To: 'Hello World <hi@example.com>',
        Cc: 'emily@example.com'
      }
    )
  end

  context 'with bcc' do
    it_should_behave_like(
      'Griddler adapter',
      :cloudmailin,
      envelope: {
        to: 'sandra@example.com',
        from: 'there@example.com'
      },
      plain: 'hi',
      headers: {
        From: 'there@example.com',
        To: 'Hello World <hi@example.com>',
        Cc: 'emily@example.com'
      }
    )
  end

  it 'normalizes parameters' do
    expect(normalized).to be_normalized_to(
      to: ['Some Identifier <some-identifier@example.com>'],
      cc: ['emily@example.com'],
      from: 'Joe User <joeuser@example.com>',
      subject: 'Re: [ThisApp] That thing',
      text: /Dear bob/
    )
  end

  it 'normalizes parameters where the recipient has been BCCed' do
    expect(normalized(bcc_params)).to be_normalized_to(
      to: ['Some Identifier <some-identifier@example.com>'],
      cc: ['emily@example.com'],
      bcc: ['sandra@example.com'],
      from: 'Joe User <joeuser@example.com>',
      subject: 'Re: [ThisApp] That thing',
      text: /Dear bob/
    )
  end

  it 'normalizes parameters where the recipient has been CCed' do
    expect(normalized(cc_params)).to be_normalized_to(
      cc: ['Some Identifier <some-identifier@example.com>'],
      to: ['emily@example.com'],
      from: 'Joe User <joeuser@example.com>',
      subject: 'Re: [ThisApp] That thing',
      text: /Dear bob/
    )
  end

  it 'changes attachments to an array of files' do
    params = default_params.merge(attachments: { '0' => upload_1, '1' => upload_2 })

    normalized_params = normalized(params)
    expect(normalized_params[:attachments]).to include(upload_1, upload_2)
    expect(normalized_params[:attachments]).not_to include('0')
    expect(normalized_params[:attachments]).not_to include('1')
  end

  it 'has no attachments' do
    expect(normalized[:attachments]).to be_empty
  end

  it 'wraps to in an array' do
    expect(normalized[:to]).to eq([default_params[:headers][:To]])
  end

  it 'wraps cc in an array' do
    expect(normalized[:cc]).to eq([default_params[:headers][:Cc]])
  end

  it 'returns an array even if cc is empty' do
    expect(normalized(nocc_params)[:cc]).to eq([])
  end

  def normalized(params = default_params)
    Griddler::Cloudmailin::Adapter.normalize_params(params)
  end

  def default_params
    {
      envelope: {
        to: 'some-identifier@example.com',
        from: 'joeuser@example.com'
      },
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
    default_params.merge(
      envelope: default_params[:envelope].merge(to: 'sandra@example.com')
    )
  end

  def nocc_params
    default_params.merge(
      headers: default_params[:headers].except(:Cc)
    )
  end

  def cc_params
    default_params.merge(
      headers: default_params[:headers].merge(
        Cc: 'Some Identifier <some-identifier@example.com>',
        To: 'emily@example.com'
      )
    )
  end
end
