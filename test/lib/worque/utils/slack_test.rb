require 'test_helper'
require 'webmock/minitest'
require 'worque/utils/slack'

describe Worque::Utils::Slack do
  describe '#post' do
    before do
      stubbed_result = {
        "ok"=>true,
        "channel"=>"G1TRB0GG1",
        "ts"=>"1469116417.000010",
        "message" => {
          "type"=>"message",
          "user"=>"U02G4HZSH",
          "text"=>"Hello World from the other side",
          "bot_id"=>"B1TQVKF9A",
          "ts"=>"1469116417.000010"
        }
      }.to_json

      stub_request(:any, 'https://slack.com/api/chat.postMessage')
        .to_return(body: stubbed_result)
    end

    it 'posts message to slack' do
      token = 'just-a-token'
      result = Worque::Utils::Slack
        .new(token)
        .post('#cam-test', "Hello World from Cam's computer")

      assert result['ok']
    end
  end
end
