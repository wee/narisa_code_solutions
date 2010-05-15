queue = []

def add(tag, level):
  head_result = ''
  sharp_i = tag.find('#')
  dot_i = tag.find('.')
  star_i = tag.find('*')
  if star_i == -1:
    repeat = 1
  else:
    repeat = int(tag[star_i+1:] )

  # create format
  fmt = '<%s %s="%s">'  
  if sharp_i != -1:
    head_result = fmt%(tag[:sharp_i], 'id', tag[sharp_i + 1 : ] )
    tail_result = '</%s>'%tag[:sharp_i]
  elif dot_i != -1:
    head_result = fmt%(tag[:dot_i], 'class', tag[dot_i + 1 : ] )
    tail_result = '</%s>'%tag[:dot_i]
  else:
    head_result = '<%s>'%tag
    tail_result = '</%s>'%tag

  # add to stack
  tmp_list = []
  while queue:
    t, l = queue.pop()
    if t.find('/') != -1 and l < level: tmp_list.append( (t,l) )
    else:
      queue.append( (t,l) ) 
      break
    
  for i in xrange( repeat ):
    queue.append( (head_result,level) )
    queue.append( (tail_result,level) )

  queue.extend(tmp_list)

  
def traverse(input,level=0):
  if input == '': return

  arrow_i = input.find('>')
  if arrow_i == -1:
    tags,rest_input = input.split('+'), '' 
  else: 
    tags,rest_input = input[:arrow_i].split('+'), input[arrow_i + 1:]
  for t in tags:
    add(t,level)

  traverse(rest_input,level+1)
  
def print_html(queue):
  for value, level in queue:
    print '\t'*level + value
  
s = raw_input('insert input : ')
traverse(s)
print_html(queue)
