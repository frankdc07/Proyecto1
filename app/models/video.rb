class Video < ApplicationRecord
  belongs_to :contest

  has_attached_file :link_original
  has_attached_file :link_converted

  has_attached_file :thumbnail, styles: { medium_nr: "250x150!" }

  validates_attachment_content_type :link_original, content_type: /\Avideo/
  validates_attachment_content_type :link_converted, content_type: /.*/

  validates_attachment_presence :link_original

  def publish!
    self.status = 'Convertido'
    save
  end

  # Checks if all formats are already encoded, the simplest way
  def all_formats_encoded?
    self.status=='Convertido' ? true : false
  end
  
  def process!
    self.status = 'Convertido'
    save
  end

# Checks if all formats are already encoded, the simplest way
  def encoded?
    self.status == 'Convertido' ? true : false
  end

  
  after_create :run_encoder

  private

  def run_encoder
    VideoProcessorJob.perform_later
  end

end
