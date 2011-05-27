require 'test_helper'

class PostsControllerTest < ActionController::TestCase
  
  test "default show route works" do
    assert_generates "/posts/1", { :controller => "posts", :action => "show", :id => "1" }
  end
  
  test "bulk show route goes to default show" do
    assert_generates "/posts/1,2,3", {  :controller => "posts", :action => "show", :id => "1,2,3" }
  end
  
  test "assignments from single id" do
    get :show, :id => '1'
    assert_equal('1',assigns[:id])
    assert_equal(['1'],assigns[:ids])
  end
  
  test "assignments from multiple ids" do
    get :show, :id => '1,2,3,4,5'
    assert_equal('1',assigns[:id])
    assert_equal(['1','2','3','4','5'],assigns[:ids])
  end
  
  test "bulk updating happy path use case" do
    put :update, :id => '1,2', :posts => {
       '1' => { 'title' => "Uno" },
       '2' => { 'title' => "Dos" }
    }
    assert_equal('Uno', Post.find(1).title)
    assert_equal('Dos', Post.find(2).title)
  end
  
  test "bulk updating with one missing item" do
    # Is it necessary to have ids if they're present in the 'posts' hash?
    put :update, :id => '1,2,3', :posts => {
      '1' => { 'title' => "Uno"  },
      '2' => { 'title' => "Dos"  },
      '3' => { 'title' => "None" }  # this one does not exist.
    }
    
    # tolerant of mistakes
    assert_equal('Uno', Post.find(1).title)
    assert_equal('Dos', Post.find(2).title)
  end
  
end
