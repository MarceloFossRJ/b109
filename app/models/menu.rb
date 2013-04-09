class Menu < ActiveRecord::Base
  has_paper_trail
  
  belongs_to :page
  
  has_many :children, :class_name => "Menu", :foreign_key => "menu_id"
  belongs_to :menu, :class_name => "Menu", :foreign_key => "menu_id"
  
  attr_accessible :is_active, :menu_id, :name, :menu_type, :menu_order, :page_id
  
  validates_presence_of :name, :menu_type, :menu_order
  validates_length_of :name, :within => 3..80
  validates_uniqueness_of :name
  validates :page_id, :presence => true,  :if => :page_exists?
  validate :page_should_not_exist
  validates :menu_id, :presence => true, :if => :menu_exists?
  validate :father_should_not_exists
    
  def page_exists?
    menu_type == 2 || menu_type == 4
  end

  def page_should_not_exist
    if !page_id.blank? and (menu_type == 3 || menu_type == 5 || menu_type == 6)
      #menu_type == 3 || menu_type == 5 || menu_type == 6
      errors.add(:page_id, "must be blank")
    end
  end  
  
  def menu_exists?
    menu_type == 2 || menu_type == 5 || menu_type == 6
  end
  
  def father_should_not_exists
    if !menu_id.blank? and (menu_type == 1 || menu_type == 3 || menu_type == 4)
      errors.add(:menu_id, "must be blank")
    end
  end
  
  #menu type somete um home e um blog menutype
  
  # Menu_type = [['Root',1],['Children',2],['Blog',3],['Home',4],['Header',5],['Separator',6]]
  # page_id obrigatório: 1-Se children, 2-Se home // validacao: page_exists?
  # page_id não preenchido: 1-Se blog, 2-Se header, 3-Se separador // validacao: page_should_not_exist
  # menu_id não preenchido: 1-Se root, 2-Se blog, 3-Se home // validacao: father_should_not_exists
  # menu_id obrigatório: 1-Se children, 2-Se separador, 3-Se header // validacao: menu_exists?
  # se children não pode ser pai => validaçao na página
  # home não pode ter filho => validaçao na página (sem opção de combo)  
    
  # se root page_id obrigatório somente se não tem filho
  # home deve ser único


end
