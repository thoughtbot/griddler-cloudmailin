require "griddler"
require "griddler/cloudmailin/version"
require "griddler/cloudmailin/adapter"

Griddler.adapter_registry.register(:cloudmailin, Griddler::Cloudmailin::Adapter)
