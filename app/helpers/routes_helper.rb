module FrancisCMS
  module Helpers
    module RoutesHelper
      # ----- Base ---------- #
      def base_url
        @base_url ||= request.base_url
      end

      def root_path
        '/'
      end

      # ----- Sessions ---------- #
      ['auth', 'login', 'logout'].each do |route|
        define_method "#{route}_path" do
          root_path + route
        end

        define_method "#{route}_url" do
          base_url + send("#{route}_path")
        end
      end

      # ----- Content ---------- #
      ['links', 'posts', 'tags'].each do |route|
        define_method "#{route}_path" do
          root_path + route
        end

        define_method "#{route}_url" do
          base_url + send("#{route}_path")
        end

        define_method "#{route.singularize}_path" do |item|
          File.join send("#{route}_path"), item.parameterize
        end

        define_method "#{route.singularize}_url" do |item|
          base_url + send("#{route.singularize}_path", item.parameterize)
        end
      end

      # ----- Create/Edit content ---------- #
      ['link', 'post'].each do |route|
        define_method "new_#{route}_path" do
          File.join send("#{route.pluralize}_path"), 'new'
        end

        define_method "edit_#{route}_path" do |item|
          File.join send("#{route}_path", item.parameterize), 'edit'
        end
      end

      # ----- Feeds ---------- #
      ['links', 'posts'].each do |route|
        define_method "#{route}_feed_path" do
          root_path + File.join(route, 'rss')
        end

        define_method "#{route}_feed_url" do
          base_url + send("#{route}_feed_path")
        end
      end
    end
  end
end