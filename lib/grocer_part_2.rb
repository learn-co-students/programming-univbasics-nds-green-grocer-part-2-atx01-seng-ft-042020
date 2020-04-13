require_relative './part_1_solution.rb'

def apply_coupons(cart, coupons)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  # cart = AoH, coupons = AoH
  # return new AoH, hash items from carts and new hashes with "ITEM W/COUPON"
  # loop through cart, each item(hash) needs to be checked in the coupon array for a valid coupon. Check that cart item is in coupon array cart[:item] == coupons[:item], if it doesnt have a coupon push item to new_array 
  # check cart[:count] >= coupons[:num] than we can apply coupon 
  # 
  new_array = []
  
  cart.each do |item|
    
    item_has_coupon_index = coupons.index do |coupon|
      coupon[:item] == item[:item]
    end #check that item has a coupon 
    
    if item_has_coupon_index 
      coupon = coupons[item_has_coupon_index]
    
      if item[:count] >= coupon[:num]
        # apply coupon and update cart 
        item[:count] -= coupon[:num] 
        new_array << item 
        new_item_hash = {
          :item => "#{coupon[:item]} W/COUPON",
          :price => coupon[:cost] / coupon[:num],
          :clearance => item[:clearance],
          :count => coupon[:num]
        }
        new_array << new_item_hash
      end #end item[count] >= coupon[:num]
    else
      # no coupon for item 
      new_array << item 
    end #end of item_has_coupon_index
    
  end #end of cart.each
  new_array
end



items = [
  {:item => "PEANUT BUTTER", :price => 2.40, :clearance => true,  :count => 2},
  {:item => "KALE", :price => 3.00, :clearance => false, :count => 3},
  {:item => "SOY MILK", :price => 3.60, :clearance => true,  :count => 1}
]
def apply_clearance(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  # cart = AoH, return new AoH, with all items, and updated price reduced by 20% if on clearance
  cart.map do |item|
    if item[:clearance]
      item[:price] = (item[:price] * 0.80).round(2)
    end
    item  
  end
end

def checkout(cart, coupons)
  # Consult README for inputs and outputs
  #
  # This method should call
  # * consolidate_cart
  # * apply_coupons
  # * apply_clearance
  #
  # BEFORE it begins the work of calculating the total (or else you might have
  # some irritated customers
  #cart = AoH, coupons = AoH, return Float:total of the cart 
  consolidated_cart = consolidate_cart(cart)
  applied_coupons = apply_coupons(consolidated_cart, coupons)
  applied_clearance = apply_clearance(applied_coupons)
  
 
  
  total = applied_clearance.reduce(0) do |sum, item|
    sum += (item[:count] * item[:price]).round(2)
  end
  if total >= 100
    return (total * 0.9).round(2) 
  end
  total 
end
