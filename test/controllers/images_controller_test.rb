require 'test_helper'

class ImagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @image = images(:one)
  end

  test "should get index" do
    get images_url, as: :json
    assert_response :success
  end

  test "should not display secrets" do
    get images_url, as: :json
    assert_nil(JSON.parse(response.body)[0]['secret'])
  end

  test "should not display private image on index" do
    get images_url, as: :json
    assert_nil(JSON.parse(response.body)[2][:secret])
  end


  test "should create image with file" do
    assert_difference('Image.admin.count') do
      post images_url, params: { image: { description: @image.description, private: @image.private, title: @image.title, image: fixture_file_upload('files/lenna.png', 'image/png') } }
    end

    assert_response 201
  end

  test "should display secret when creating" do
    assert_difference('Image.admin.count') do
      post images_url, params: { image: { description: @image.description, private: @image.private, title: @image.title, image: fixture_file_upload('files/lenna.png', 'image/png') } }
    end

    assert_not_nil(JSON.parse(response.body)['secret'])
  end

  test "should create image with url" do
    assert_difference('Image.admin.count') do
      post images_url, params: { image: { description: @image.description, private: @image.private, title: @image.title, remote_image_url: 'http://i.imgur.com/JVF33ix.jpg' } }
    end

    assert_response 201
  end

  test "should override upload by remote file" do
    assert_difference('Image.admin.count', 1) do
      post images_url, params: { image: { description: @image.description, private: @image.private, title: @image.title, image: fixture_file_upload('files/lenna.png', 'image/png'), remote_image_url: 'http://i.imgur.com/JVF33ix.jpg' } }
    end

    assert_response 201
    assert_equal(JSON.parse(response.body)['url'].end_with?('JVF33ix.jpg'), true)
  end

  test "should show image" do
    get image_url(@image), as: :json
    assert_response :success
  end

  test "should not update image" do
    patch image_url(@image), params: { image: { description: @image.description, private: @image.private, title: @image.title } }, as: :json
    assert_response 403
  end

  test "should update image" do
    # Ensuring the file is here, otherwise carrierwave raises an error "empty file" and validation fails
    File.open(File.join(Rails.root, 'test', 'fixtures', 'files', 'lenna.png')) do |f|
      @image.image = f
    end
    @image.save

    patch image_url(@image), params: { secret: 'potato', image: { description: @image.description, private: @image.private, title: @image.title } }, as: :json
    assert_response 200
  end

  test "should not destroy image without secret" do
    @image.secret = nil
    assert_difference('Image.admin.count', 0) do
      delete image_url(@image), as: :json
    end

    assert_response 403
  end

  test "should destroy image with secret" do
    assert_difference('Image.admin.count', -1) do
      delete image_url(@image, params: {secret: 'potato'}), as: :json
    end

    assert_response 204
  end

  test "should load exactly 20 images" do
    get images_url, as: :json
    assert_equal JSON.parse(response.body).length, 20
  end
end
