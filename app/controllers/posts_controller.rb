class PostsController < ApplicationController
  
  before_filter :separate_bulk_ids
  
  # GET /posts/1
  #  params[:id]   => 1
  #  params[:ids]  => [ 1 ]
  #
  # GET /posts/1,2,3,4
  #  params[:id]   => 1
  #  params[:ids]  => [ 1, 2, 3, 4 ]
  # 
  def show
    # Demonstrates how IDs are separated.  Assigned to instance
    # variables for testing purposes.
    @id = params[:id]
    @ids = params[:ids]
    head :ok
  end  
  
  # PUT /posts/1,2,3,4
  def update
    # Strict, no policy enforcement == Dangerous and harder to use?
    Post.update(params[:posts].keys, params[:posts].values)
    head :ok
  end
     
  protected
  
    def separate_bulk_ids
      if params[:id].present?
        params[:ids] = params[:id].split(',')
        params[:id] = params[:ids].first
      end
    end
  
end
