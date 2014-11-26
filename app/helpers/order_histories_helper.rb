module OrderHistoriesHelper
	# Added for getting ratings on order history page
  	# On 26/11/2014 By Pradnya Kulkarni
  	# Contact: pradnya@sodelsolutions.com
  	def get_ratings(order_id, food_item_id)
    	review = Review.find_by_hola_user_id_and_order_id_and_food_item_id(hola_current_user, order_id, food_item_id)
    	if review.present?
      		ratings = review.try(:ratings)
    	else
      		ratings = ''
    	end
    	return ratings
    end

end
