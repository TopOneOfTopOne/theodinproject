class LessonsController < ApplicationController

  def index
    @course = find_course

    not_found_error if @course.nil?
  end

  def show
    @course = find_course
    @lesson = find_lesson unless @course.nil?

    not_found_error if @course.nil? || @lesson.nil?

    if show_ads?
      @lower_banner_ad = true
      @right_box_ad = true
    end
  end

  private

  def find_course
    @find_course ||= Course.find_by_title_url(params[:course_name])
  end

  def find_lesson
    @find_lesson ||= find_course.lessons.find_by_title_url(params[:lesson_name])
  end

  def show_ads?
    ENV["SHOW_ADS"] && Ad.show_ads?(current_user)
  end

  def not_found_error
    raise ActionController::RoutingError.new('Not Found')
  end
end
