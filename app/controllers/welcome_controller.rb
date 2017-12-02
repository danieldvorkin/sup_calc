class WelcomeController < ApplicationController
  def index
    @data = [{
              link: "https://s3-us-west-2.amazonaws.com/premecalc/img1.jpg",
              bigT: "Fastest Search",
              smallT: "Look through all the products in an organized weekly drop format.",
              position: 'center',
              color: "white"
            },{
              link: "https://s3-us-west-2.amazonaws.com/premecalc/img2.jpg",
              bigT: "Saved Orders",
              smallT: "Store, Share, and edit wishlists, mock orders and saved orders.",
              position: 'left',
              color: "white"
            },{
              link: "https://s3-us-west-2.amazonaws.com/premecalc/img3.jpg",
              bigT: "Flexible Cart System",
              smallT: "With a very flexible cart system, you can find out all the pricing info you need to stay prepared.",
              position: 'right',
              color: "black"
            },{
              link: "https://s3-us-west-2.amazonaws.com/premecalc/img4.jpg",
              bigT: "Custom Settings",
              smallT: "With our advanced margin setting and calculations, you can know what the optimal sell price would be to make a lil extra this week.",
              position: 'center',
              color: "black"
            }]
  end
end
