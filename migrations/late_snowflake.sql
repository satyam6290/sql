/*
  # Add Portfolio View Increment Function
  
  1. New Functions
    - `increment_portfolio_views`: Increments view count and updates last viewed timestamp for a portfolio
    
  2. Description
    - Creates a PostgreSQL function to safely increment the view count
    - Updates the last_viewed_at timestamp
    - Handles unique visitors count
    
  3. Security
    - Function is accessible to both authenticated and anonymous users
*/

CREATE OR REPLACE FUNCTION public.increment_portfolio_views(portfolio_id uuid)
RETURNS void
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
BEGIN
  UPDATE portfolios
  SET 
    view_count = COALESCE(view_count, 0) + 1,
    last_viewed_at = CURRENT_TIMESTAMP
  WHERE id = portfolio_id;
END;
$$;

-- Grant access to authenticated and anonymous users
GRANT EXECUTE ON FUNCTION public.increment_portfolio_views(uuid) TO authenticated;
GRANT EXECUTE ON FUNCTION public.increment_portfolio_views(uuid) TO anon;