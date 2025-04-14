/*
  # Create Storage Buckets and Policies
  
  1. New Storage Buckets
    - `testimonials`: For storing testimonial author avatars
    - `projects`: For storing project images and media
    - `blog_images`: For storing blog post images
    - `avatars`: For storing user profile avatars
    - `covers`: For storing portfolio cover images
    
  2. Security Policies
    - Public read access for all buckets
    - Write access restricted to authenticated users for their own files
*/

-- Create buckets if they don't exist
DO $$
BEGIN
  INSERT INTO storage.buckets (id, name, public)
  VALUES 
    ('testimonials', 'testimonials', true),
    ('projects', 'projects', true),
    ('blog_images', 'blog_images', true),
    ('avatars', 'avatars', true),
    ('covers', 'covers', true)
  ON CONFLICT (id) DO NOTHING;
END $$;

-- Drop existing policies to avoid conflicts
DO $$
BEGIN
  DROP POLICY IF EXISTS "Testimonial images are publicly accessible" ON storage.objects;
  DROP POLICY IF EXISTS "Users can upload testimonial images" ON storage.objects;
  DROP POLICY IF EXISTS "Users can update their testimonial images" ON storage.objects;
  DROP POLICY IF EXISTS "Users can delete their testimonial images" ON storage.objects;
  
  DROP POLICY IF EXISTS "Project images are publicly accessible" ON storage.objects;
  DROP POLICY IF EXISTS "Users can upload project images" ON storage.objects;
  DROP POLICY IF EXISTS "Users can update their project images" ON storage.objects;
  DROP POLICY IF EXISTS "Users can delete their project images" ON storage.objects;
  
  DROP POLICY IF EXISTS "Blog images are publicly accessible" ON storage.objects;
  DROP POLICY IF EXISTS "Users can upload blog images" ON storage.objects;
  DROP POLICY IF EXISTS "Users can update their blog images" ON storage.objects;
  DROP POLICY IF EXISTS "Users can delete their blog images" ON storage.objects;
  
  DROP POLICY IF EXISTS "Avatar images are publicly accessible" ON storage.objects;
  DROP POLICY IF EXISTS "Users can upload avatar images" ON storage.objects;
  DROP POLICY IF EXISTS "Users can update their avatar images" ON storage.objects;
  DROP POLICY IF EXISTS "Users can delete their avatar images" ON storage.objects;
  
  DROP POLICY IF EXISTS "Cover images are publicly accessible" ON storage.objects;
  DROP POLICY IF EXISTS "Users can upload cover images" ON storage.objects;
  DROP POLICY IF EXISTS "Users can update their cover images" ON storage.objects;
  DROP POLICY IF EXISTS "Users can delete their cover images" ON storage.objects;
END $$;

-- Create new policies
DO $$
BEGIN
  -- Testimonials bucket policies
  EXECUTE format('CREATE POLICY "Testimonial images are publicly accessible" ON storage.objects FOR SELECT USING (bucket_id = ''testimonials'')');
  EXECUTE format('CREATE POLICY "Users can upload testimonial images" ON storage.objects FOR INSERT TO authenticated WITH CHECK (bucket_id = ''testimonials'' AND (storage.foldername(name))[1] = auth.uid()::text)');
  EXECUTE format('CREATE POLICY "Users can update their testimonial images" ON storage.objects FOR UPDATE TO authenticated USING (bucket_id = ''testimonials'' AND (storage.foldername(name))[1] = auth.uid()::text)');
  EXECUTE format('CREATE POLICY "Users can delete their testimonial images" ON storage.objects FOR DELETE TO authenticated USING (bucket_id = ''testimonials'' AND (storage.foldername(name))[1] = auth.uid()::text)');

  -- Projects bucket policies
  EXECUTE format('CREATE POLICY "Project images are publicly accessible" ON storage.objects FOR SELECT USING (bucket_id = ''projects'')');
  EXECUTE format('CREATE POLICY "Users can upload project images" ON storage.objects FOR INSERT TO authenticated WITH CHECK (bucket_id = ''projects'' AND (storage.foldername(name))[1] = auth.uid()::text)');
  EXECUTE format('CREATE POLICY "Users can update their project images" ON storage.objects FOR UPDATE TO authenticated USING (bucket_id = ''projects'' AND (storage.foldername(name))[1] = auth.uid()::text)');
  EXECUTE format('CREATE POLICY "Users can delete their project images" ON storage.objects FOR DELETE TO authenticated USING (bucket_id = ''projects'' AND (storage.foldername(name))[1] = auth.uid()::text)');

  -- Blog images bucket policies
  EXECUTE format('CREATE POLICY "Blog images are publicly accessible" ON storage.objects FOR SELECT USING (bucket_id = ''blog_images'')');
  EXECUTE format('CREATE POLICY "Users can upload blog images" ON storage.objects FOR INSERT TO authenticated WITH CHECK (bucket_id = ''blog_images'' AND (storage.foldername(name))[1] = auth.uid()::text)');
  EXECUTE format('CREATE POLICY "Users can update their blog images" ON storage.objects FOR UPDATE TO authenticated USING (bucket_id = ''blog_images'' AND (storage.foldername(name))[1] = auth.uid()::text)');
  EXECUTE format('CREATE POLICY "Users can delete their blog images" ON storage.objects FOR DELETE TO authenticated USING (bucket_id = ''blog_images'' AND (storage.foldername(name))[1] = auth.uid()::text)');

  -- Avatars bucket policies
  EXECUTE format('CREATE POLICY "Avatar images are publicly accessible" ON storage.objects FOR SELECT USING (bucket_id = ''avatars'')');
  EXECUTE format('CREATE POLICY "Users can upload avatar images" ON storage.objects FOR INSERT TO authenticated WITH CHECK (bucket_id = ''avatars'' AND (storage.foldername(name))[1] = auth.uid()::text)');
  EXECUTE format('CREATE POLICY "Users can update their avatar images" ON storage.objects FOR UPDATE TO authenticated USING (bucket_id = ''avatars'' AND (storage.foldername(name))[1] = auth.uid()::text)');
  EXECUTE format('CREATE POLICY "Users can delete their avatar images" ON storage.objects FOR DELETE TO authenticated USING (bucket_id = ''avatars'' AND (storage.foldername(name))[1] = auth.uid()::text)');

  -- Covers bucket policies
  EXECUTE format('CREATE POLICY "Cover images are publicly accessible" ON storage.objects FOR SELECT USING (bucket_id = ''covers'')');
  EXECUTE format('CREATE POLICY "Users can upload cover images" ON storage.objects FOR INSERT TO authenticated WITH CHECK (bucket_id = ''covers'' AND (storage.foldername(name))[1] = auth.uid()::text)');
  EXECUTE format('CREATE POLICY "Users can update their cover images" ON storage.objects FOR UPDATE TO authenticated USING (bucket_id = ''covers'' AND (storage.foldername(name))[1] = auth.uid()::text)');
  EXECUTE format('CREATE POLICY "Users can delete their cover images" ON storage.objects FOR DELETE TO authenticated USING (bucket_id = ''covers'' AND (storage.foldername(name))[1] = auth.uid()::text)');
END $$;