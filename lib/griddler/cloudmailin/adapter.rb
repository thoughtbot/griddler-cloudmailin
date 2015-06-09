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
        {
          to: params[:envelope][:to].split(','),
          cc: ccs,
          from: params[:envelope][:from],
          subject: params[:headers][:Subject],
          text: params[:plain],
          attachments: params.fetch(:attachments) { [] },
          headers: params[:headers]
        }
      end

      private

      attr_reader :params

      def ccs
        params[:headers][:Cc].to_s.split(',').map(&:strip)
      end
    end
  end
end
