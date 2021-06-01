class EventsController < ApplicationController
  before_action :require_admin, only: [:new, :edit, :update, :create, :destroy, :list]

  def index
    @events = Event.all
  end

  def show
    @event = Event.find(params[:id])
    @users = User.all
    # 申し込み者一覧を配列に格納する
    applicants = @users.find_all{|user| @event.applicant_ids.include?(user.id)}
    # 配列に対してページネイトする
    @applicants = Kaminari.paginate_array(applicants).page(params[:page]).per(10)
  end

  def new
    @event = Event.new
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    event = Event.find(params[:id])
    event.update!(event_params)
    redirect_to list_events_path, notice: "「#{event.title}を編集しました」"
  end

  def create
    @event = current_user.events.new(event_params)
    if @event.save
        redirect_to list_events_url, notice: "「#{@event.title}」を投稿しました。"
    else
      render :new
    end
  end

  def destroy
    event = Event.find(params[:id])
    event.destroy
    redirect_to list_events_url, notice: "「#{event.title}」を削除しました。"
  end

  def apply
    @event = Event.find(params[:id])
    EventApplicant.create(event_id: @event.id, applicant_id: current_user.id)
    flash[:notice] = '申し込みが完了しました。'
    redirect_to action: "show"
  end

  def cancel
    @event = Event.find(params[:id])
    event_applicant = EventApplicant.find_by(event_id: @event.id, applicant_id: params[:applicant_id])
    event_applicant.destroy
    flash[:notice] = 'キャンセルが完了しました。'
    redirect_to action: "show"
  end
  def request
    @event = Event.find(params[:id])
    event_applicant = EventApplicant.find_by(event_id: @event.id, applicant_id: current_user.id)
    event_applicant.request = true
  end

  def list
    @events = Event.all.page(params[:page]).per(5)
  end

  def applicant
    # current_userの申し込みを配列に格納する
    events = Event.all.find_all{ |event| current_user.event_applicants.map(&:event_id).include?(event.id) }
    # 配列に対してページネイトする
    @events = Kaminari.paginate_array(events).page(params[:page]).per(5)
  end

  private
  
  def event_params
    params.require(:event).permit(:title, :description, :wages, :start, :end)
  end

end