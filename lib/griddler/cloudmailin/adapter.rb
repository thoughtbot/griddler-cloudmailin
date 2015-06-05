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
        params.merge(
          to: tos,
          cc: ccs,
          from: params[:envelope][:from],
          subject: params[:headers][:Subject],
          text: params[:plain],
          attachments: params.fetch(:attachments) { [] },
        )
      end

      private

      attr_reader :params

      def recipients(section, field)
        params[section][field].to_s.split(',').map(&:strip)
      end

      def ccs
        recipients(:headers, :Cc)
      end

      def tos
        recipients(:headers, :To) | recipients(:envelope, :to)
      end
    end
  end
end
