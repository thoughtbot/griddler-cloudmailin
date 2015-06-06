require 'active_support/core_ext/string/strip'

module Griddler
  module Cloudmailin
    class Adapter
      def initialize(params)
        @params = params
      end

      def self.normalize_params(params)
        adapter = new(params)
        adapter.normalize_params
      end

      def normalize_params
        normalized_params = {
          to: tos,
          cc: ccs,
          from: params[:headers][:From],
          subject: params[:headers][:Subject],
          text: params[:plain],
          attachments: params.fetch(:attachments) { [] },
        }

        normalized_params[:bcc] = bcc unless bcc.empty?
        normalized_params
      end

      private

      attr_reader :params

      def recipients(field)
        params[:headers][field].to_s.split(',').map(&:strip)
      end

      def ccs
        @ccs ||= recipients(:Cc)
      end

      def tos
        @tos ||= recipients(:To)
      end

      def bcc
        return @bcc if @bcc
        envelope_to = params[:envelope][:to]
        header_to_emails = tos.map do |to|
          Griddler::EmailParser.parse_address(to)[:email]
        end
        @bcc = header_to_emails.include?(envelope_to) ? [] : [envelope_to]
      end
    end
  end
end
