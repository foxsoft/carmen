# https://blog.eq8.eu/til/factory-bot-trait-for-active-storange-has_attached.html
module FilesTestHelper
  extend self
  extend ActionDispatch::TestProcess

  def png_name;
    'test.png'
  end

  def png;
    upload(png_name, 'image/png')
  end

  def jpg_name;
    'test.jpg'
  end

  def jpg;
    upload(jpg_name, 'image/jpg')
  end

  def pdf_name;
    'test.pdf'
  end

  def pdf;
    upload(pdf_name, 'application/pdf')
  end

  private

    def upload(name, type)
      file_path = Rails.root.join('spec', 'fixtures', 'files', name)
      fixture_file_upload(file_path, type)
    end
end
