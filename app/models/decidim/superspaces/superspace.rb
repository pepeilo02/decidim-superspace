# frozen_string_literal: true

module Decidim
  module Superspaces
    class Superspace < ApplicationRecord
      include Decidim::Loggable
      include Decidim::Traceable
      include Decidim::TranslatableResource
      include Decidim::HasUploadValidations

      has_one_attached :hero_image
      validates_upload :hero_image, uploader: Decidim::HeroImageUploader

      translatable_fields :title

      has_many :superspaces_participatory_spaces, foreign_key: "decidim_superspaces_superspace_id"

      belongs_to :organization,
                 foreign_key: "decidim_organization_id",
                 class_name: "Decidim::Organization"

      def participatory_spaces
        superspaces_participatory_spaces.map(&:participatory_space)
      end
      
      def self.log_presenter_class_for(_log) = Decidim::Superspaces::AdminLog::SuperspacePresenter
    end
  end
end
