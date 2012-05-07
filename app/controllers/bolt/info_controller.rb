module Bolt
  class InfoController < Bolt::BoltController
    layout "default_site"
    def show   
       @site_settings=Setting.find(1)   
      @top_menu = Page.parent_menu
      if(!params[:cat_name].nil?)
        if(!params[:cat_name].match(/article/i).nil?)
          if(!params[:id].nil?)
            @article = Article.find(params[:id].to_i)
          end
        else
          @articles = Article.published
        end      
      else
        @categories = Category.all        
        if(params[:id].nil? || !params[:id].match(/index|home/i).nil?)
          @page = Page.find_by_title("Home")        
        else      
          @page = Page.find_by_title(deformat_url_id(params[:id]))
        end
       
      end
    end
  end
end 
