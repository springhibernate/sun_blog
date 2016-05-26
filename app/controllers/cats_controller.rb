class CatsController < ApplicationController
  # GET /cats
  # GET /cats.xml
  def index
    @cats = Cat.paginate :page=>params[:page],:order=>"id desc",:per_page=>PER_PAGE
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @cats }
    end
  end

  # GET /cats/1
  # GET /cats/1.xml
  def show
    @cat = Cat.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @cat }
    end
  end

  # GET /cats/new
  # GET /cats/new.xml
  def new
    @cat = Cat.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @cat }
    end
  end

  # GET /cats/1/edit
  def edit
    @cat = Cat.find(params[:id])
  end

  #convert chinese to pinyin,the seperator is -
  def to_pinyin(chinese)
    #return Pinyin.t(chinese, '-')
    #return HanziToPinyin.hanzi_to_url(chinese)
    return chinese
  end

  # POST /cats
  # POST /cats.xml
  def create
    @cat = Cat.new(params[:cat])
    @cat.cat_name_en=to_pinyin(@cat.cat_name)
    respond_to do |format|
      if @cat.save
        format.html { redirect_to(cats_url, :notice => t('create_successfully')) }
        format.xml  { render :xml => @cat, :status => :created, :location => @cat }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @cat.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /cats/1
  # PUT /cats/1.xml
  def update
    @cat = Cat.find(params[:id])
    @cat.assgin_attributes(params[:cat])
    @cat.cat_name_en=to_pinyin(@cat.cat_name)
    respond_to do |format|
      if @cat.save
        format.html { redirect_to(cats_url, :notice => t('update_successfully')) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @cat.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /cats/1
  # DELETE /cats/1.xml
  def destroy
    @cat = Cat.find(params[:id])
    @cat.destroy

    respond_to do |format|
      format.html { redirect_to(cats_url,:notice => 'Cat was successfully deleted.') }
      format.xml  { head :ok }
    end
  end
end
