# Chainable methods
# TODO: think about it
module RubyInChains
protected
  # TODO: thing about default value if chain is broken
  def chainable(method_name)
    alias_method "#{method_name}_original", method_name
    chains = ["original"]
    define_method method_name do
      catch :break_chain do
        chains.each ...
      end
    end
  end
  
  def chain_order(new_order); raise NotImplementedError "TODO: implement this" end
  
  # throw :break_chain to abort chain
  def in_chain(method_name); raise NotImplementedError "TODO: implement this" end
  
end