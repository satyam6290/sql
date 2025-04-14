/*
  # Portfolio Platform Enhancements

  1. Theme Customization
    - Add theme_color column for custom accent color
    - Add theme_template column for different layout templates
  
  2. Portfolio Analytics
    - Create views table to track portfolio visits
    - Add analytics columns to portfolios table
  
  3. Project Showcase
    - Create projects table with detailed project information
    - Support for images, videos, and GitHub integration
  
  4. Testimonials
    - Create testimonials table for recommendations
    - Add moderation status field
  
  5. Resume Templates
    - Add resume_template column to portfolios
*/

-- 1. Theme Customization
ALTER TABLE portfolios
ADD COLUMN IF NOT EXISTS theme_color text DEFAULT '#3b82f6',
ADD COLUMN IF NOT EXISTS theme_template text DEFAULT 'standard';

-- 2. Portfolio Analytics
CREATE TABLE IF NOT EXISTS portfolio_views (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  portfolio_id uuid REFERENCES portfolios(id) NOT NULL,
  visitor_ip text,
  visitor_country text,
  visitor_city text,
  visitor_device text,
  section_viewed text,
  view_duration integer,
  created_at timestamptz DEFAULT now()
);

ALTER TABLE portfolios
ADD COLUMN IF NOT EXISTS view_count integer DEFAULT 0,
ADD COLUMN IF NOT EXISTS unique_visitors integer DEFAULT 0,
ADD COLUMN IF NOT EXISTS last_viewed_at timestamptz;

-- Enable RLS on portfolio_views
ALTER TABLE portfolio_views ENABLE ROW LEVEL SECURITY;

-- Allow portfolio owners to view their analytics
CREATE POLICY "Portfolio owners can view their analytics"
  ON portfolio_views
  FOR SELECT
  TO authenticated
  USING (
    EXISTS (
      SELECT 1 FROM portfolios
      WHERE portfolios.id = portfolio_views.portfolio_id
      AND portfolios.user_id = auth.uid()
    )
  );

-- Allow anyone to create a view record
CREATE POLICY "Anyone can create view records"
  ON portfolio_views
  FOR INSERT
  TO anon, authenticated
  WITH CHECK (true);

-- 3. Project Showcase
CREATE TABLE IF NOT EXISTS portfolio_projects (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  portfolio_id uuid REFERENCES portfolios(id) NOT NULL,
  title text NOT NULL,
  description text NOT NULL,
  technologies text[] NOT NULL,
  image_url text,
  video_url text,
  github_url text,
  live_url text,
  featured boolean DEFAULT false,
  sort_order integer DEFAULT 0,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

-- Enable RLS on portfolio_projects
ALTER TABLE portfolio_projects ENABLE ROW LEVEL SECURITY;

-- Allow portfolio owners to manage their projects
CREATE POLICY "Portfolio owners can manage their projects"
  ON portfolio_projects
  FOR ALL
  TO authenticated
  USING (
    EXISTS (
      SELECT 1 FROM portfolios
      WHERE portfolios.id = portfolio_projects.portfolio_id
      AND portfolios.user_id = auth.uid()
    )
  );

-- Allow anyone to view projects
CREATE POLICY "Anyone can view projects"
  ON portfolio_projects
  FOR SELECT
  TO anon, authenticated
  USING (true);

-- 4. Testimonials
CREATE TABLE IF NOT EXISTS portfolio_testimonials (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  portfolio_id uuid REFERENCES portfolios(id) NOT NULL,
  author_name text NOT NULL,
  author_title text,
  author_company text,
  author_avatar_url text,
  content text NOT NULL,
  rating integer,
  is_approved boolean DEFAULT false,
  is_featured boolean DEFAULT false,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

-- Enable RLS on portfolio_testimonials
ALTER TABLE portfolio_testimonials ENABLE ROW LEVEL SECURITY;

-- Allow portfolio owners to manage testimonials
CREATE POLICY "Portfolio owners can manage testimonials"
  ON portfolio_testimonials
  FOR ALL
  TO authenticated
  USING (
    EXISTS (
      SELECT 1 FROM portfolios
      WHERE portfolios.id = portfolio_testimonials.portfolio_id
      AND portfolios.user_id = auth.uid()
    )
  );

-- Allow anyone to view approved testimonials
CREATE POLICY "Anyone can view approved testimonials"
  ON portfolio_testimonials
  FOR SELECT
  TO anon, authenticated
  USING (is_approved = true);

-- 5. Resume Templates
ALTER TABLE portfolios
ADD COLUMN IF NOT EXISTS resume_template text DEFAULT 'professional';