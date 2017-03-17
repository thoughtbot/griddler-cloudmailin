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
    params = BASE_PARAMS.merge(attachments: { '0' => upload_1, '1' => upload_2 })

    normalized_params = normalized(params)
    expect(normalized_params[:attachments]).to include(upload_1, upload_2)
    expect(normalized_params[:attachments]).not_to include('0')
    expect(normalized_params[:attachments]).not_to include('1')
  end

  it 'has no attachments' do
    expect(normalized[:attachments]).to be_empty
  end

  it 'wraps to in an array' do
    expect(normalized[:to]).to eq([BASE_PARAMS[:headers][:to]])
  end

  it 'wraps cc in an array' do
    expect(normalized[:cc]).to eq([BASE_PARAMS[:headers][:cc]])
  end

  it 'returns the date' do
    expect(normalized[:date]).to eq(BASE_PARAMS[:headers][:date].to_datetime)
  end

  it 'returns an array even if cc is empty' do
    expect(normalized(nocc_params)[:cc]).to eq([])
  end

  it 'detects which format of params is in use' do
    expect(Griddler::Cloudmailin::Adapter.new(BASE_PARAMS).legacy?).to be_falsey
    expect(Griddler::Cloudmailin::Adapter.new(BASE_PARAMS_LEGACY).legacy?).to be_truthy
  end

  def normalized(params = BASE_PARAMS)
    Griddler::Cloudmailin::Adapter.normalize_params(params)
  end

  def bcc_params
    BASE_PARAMS.merge(
      envelope: BASE_PARAMS[:envelope].merge(to: 'sandra@example.com')
    )
  end

  def nocc_params
    BASE_PARAMS.merge(
      headers: BASE_PARAMS[:headers].except(:cc)
    )
  end

  def cc_params
    BASE_PARAMS.merge(
      headers: BASE_PARAMS[:headers].merge(
        cc: 'Some Identifier <some-identifier@example.com>',
        to: 'emily@example.com'
      )
    )
  end

  BASE_PARAMS = {
    envelope: {
      to: 'some-identifier@example.com',
      from: 'joeuser@example.com'
    },
    headers: {
      subject: 'Re: [ThisApp] That thing',
      from: 'Joe User <joeuser@example.com>',
      to: 'Some Identifier <some-identifier@example.com>',
      cc: 'emily@example.com',
      date: 'Fri, 30 Sep 2016 10:30:15 +0200'
    },
    plain: "Dear bob\n\nReply ABOVE THIS LINE\n\nhey sup"
  }.freeze

  BASE_PARAMS_LEGACY = {
    envelope: {
      to: 'some-identifier@example.com',
      from: 'joeuser@example.com'
    },
    headers: {
      Subject: 'Re: [ThisApp] That thing',
      From: 'Joe User <joeuser@example.com>',
      To: 'Some Identifier <some-identifier@example.com>',
      Cc: 'emily@example.com',
      Date: 'Fri, 30 Sep 2016 10:30:15 +0200'
    },
    plain: "Dear bob\n\nReply ABOVE THIS LINE\n\nhey sup"
  }.freeze
end
