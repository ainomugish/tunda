class Product < ActiveRecord::Base
	#attr_accessible :image
	before_destroy :ensure_not_referenced_by_any_line_item
	has_attached_file :image, :styles => { :medium => "320x240" },
		:path => ":rails_root/public/system/:attachment/:id/:style/:filename",
    :url => "/system/:attachment/:id/:style/:filename"
	belongs_to :user

	validates :title, :description, :presence => true
	validates :price, :numericality => {:greater_than_or_equal_to => 0.01}
	validates :title, :uniqueness => true
	#validates_attachment :image, :presence => true,
	#							:content_type => { :content_type => ['image/jpg', 'image/jpeg','image/gif','image/png',]},
	#							:size => { less_than: 5.megabytes}									
	
	# ensure that there are no line items referencing this product
	def ensure_not_referenced_by_any_line_item
		if line_items.count.zero?
			return true
		else
			errors.add(:base, 'Line Items present' )
			return false
		end
	end


	belongs_to :user
	#belongs_to :order
	has_many :line_items

									
end
