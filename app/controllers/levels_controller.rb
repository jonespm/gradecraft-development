class LevelsController < ApplicationController
  before_action :ensure_staff?

  before_action :find_level, except: [:create]

  def create
    @level = Level.create level_params
    respond_with @level, layout: false
  end

  def destroy
    @level.destroy
    render head: :ok, body: nil
  end

  def update
    @level.update_attributes level_params
    respond_with @level, layout: false
  end

  private

  def level_params
    params.require(:level).permit :name, :description, :points, :criterion_id, :full_credit,
      :no_credit, :sort_order
  end

  def find_level
    @level = Level.find params[:id]
  end
end
