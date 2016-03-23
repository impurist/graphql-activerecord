require 'graphql'

require 'graphql/models/monkey_patches/base_type'
require 'graphql/models/monkey_patches/graphql_relay_global_node_identification'
require 'graphql/models/monkey_patches/graphql_query_context'
require 'graphql/models/monkey_patches/graphql_relay_connection_field'
require 'graphql/models/active_record_extension'

# Helpers
require 'graphql/models/definer'
require 'graphql/models/association_load_request'
require 'graphql/models/loader'

# Order matters...
require 'graphql/models/promise_relation_connection'
require 'graphql/models/relation_load_request'
require 'graphql/models/identification'
require 'graphql/models/identification/attribute_type_definition'
require 'graphql/models/identification/attribute_types'
require 'graphql/models/identification/node_identification'
require 'graphql/models/identification/model_types'
require 'graphql/models/proxy_block'
require 'graphql/models/scalar_types'
require 'graphql/models/definition_helpers'
require 'graphql/models/definition_helpers/associations'
require 'graphql/models/definition_helpers/attributes'
require 'graphql/models/model_type_config'
require 'graphql/models/model_type'

module GraphQL
  module Models
    # Returns a promise that will traverse the associations and resolve to the model at the end of the path.
    # You can use this to access associated models inside custom field resolvers, without losing optimization
    # benefits.
    def self.load_association(starting_model, path, context)
      GraphQL::Models::DefinitionHelpers.load_and_traverse(starting_model, path, context)
    end

    def self.field_info(model_type, field_name)
      field_name = field_name.to_s

      meta = model_type.instance_variable_get(:@_graphql_field_metadata)
      return nil unless meta

      meta[field_name]
    end
  end
end
