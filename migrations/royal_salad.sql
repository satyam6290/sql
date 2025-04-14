/*
  # Create increment functions for portfolio views and blog interactions
  
  1. New Functions
    - increment_portfolio_views: Increment view count for portfolios
    - increment_blog_view: Increment view count for blog posts
    - increment_blog_comment: Increment comment count for blog posts
    
  2. Description
    - Creates PostgreSQL functions to safely increment counters
    - Uses atomic operations to prevent race conditions
*/

CREATE OR REPLACE FUNCTION increment_portfolio_views(portfolio_id uuid)
RETURNS void AS $$
BEGIN
  UPDATE portfolios
  SET 
    view_count = COALESCE(view_count, 0) + 1,
    unique_visitors = COALESCE(unique_visitors, 0) + 1,
    last_viewed_at = NOW()
  WHERE id = portfolio_id;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION increment_blog_view(post_id uuid)
RETURNS void AS $$
BEGIN
  UPDATE blog_posts
  SET view_count = COALESCE(view_count, 0) + 1
  WHERE id = post_id;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION increment_blog_comment(post_id uuid)
RETURNS void AS $$
BEGIN
  UPDATE blog_posts
  SET comment_count = COALESCE(comment_count, 0) + 1
  WHERE id = post_id;
END;
$$ LANGUAGE plpgsql;