class RulesController < ApplicationController
  before_action :set_rule, only: [:show, :edit, :update, :destroy]
    skip_before_action :require_login, only: [:index, :show, :categories, :old, :committees]
  # GET /rules
  # GET /rules.json
  def index
    @rules = Rule.all.order("title ASC")
    @category = Category.all.order("name ASC")
      if params[:search]
        @rules = Rule.search(params[:search]).order("title ASC")
      else
        @rules = Rule.all.order("title ASC")
      end
    valid_rules_only
  end

  def old
    @rules = Rule.all.order("title ASC")
    @rules = Rule.where(title: "Aufräumen")
    @category = Category.all.order("name ASC")
      if params[:search]
        @rules = Rule.search(params[:search]).where('is_valid != ? OR valid_until < ?', true, Date.today).order("title ASC")
      else
        @rules = Rule.where('is_valid != ? OR valid_until < ?', true, Date.today).order("title ASC")
      end
  end
  
  def valid_rules_only
    @rules = @rules.where('is_valid = ?', true) - @rules.where('valid_until < ?', Date.today)
  end
  # GET /rules/1
  # GET /rules/1.json
  def show
  end

  # GET /rules/new
  def new
    @rule = Rule.new
  end

  # GET /rules/1/edit
  def edit
  end

  # POST /rules
  # POST /rules.json
  def create
    @rule = Rule.new(rule_params)

    respond_to do |format|
      if @rule.save
        format.html { redirect_to @rule, notice: 'Regel erstellt.' }
        format.json { render :show, status: :created, location: @rule }
      else
        format.html { render :new }
        format.json { render json: @rule.errors, status: :unprocessable_entity }
      end
    end
  end
  
  # PATCH/PUT /rules/1
  # PATCH/PUT /rules/1.json
  def update
    respond_to do |format|
      if @rule.update(rule_params)
        format.html { redirect_to @rule, notice: 'Regel aktualisiert.' }
        format.json { render :show, status: :ok, location: @rule }
      else
        format.html { render :edit }
        format.json { render json: @rule.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rules/1
  # DELETE /rules/1.json
  def destroy
    @rule.destroy
    respond_to do |format|
      format.html { redirect_to rules_url, notice: 'Regel gelöscht.' }
      format.json { head :no_content }
    end
  end
  
  def categories
    @category = Category.find(params[:id])
    @rules=Rule.all
      if params[:search]
        @rules = Rule.search(params[:search])
      else
        @rules = Rule.all
      end
    valid_rules_only
    @rules= @rules & Rule.joins(:categories).where(:categories => {id: @category.id})
    
  end
  
  
 def committees
    
    @committee = Committee.find(params[:id])
    
    if params[:search]
        @rules = Rule.search(params[:search]).where(committee_id:@committee.id).order("created_at DESC")
    else
        @rules = Rule.where(committee_id:@committee.id).order('created_at DESC')
    end
    valid_rules_only
    
    
 end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rule
      @rule = Rule.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def rule_params
      params.require(:rule).permit(:is_valid, :title, :content, :created_at, :updated_at, :valid_until, :committee_id, category_ids:[])
    end
end
