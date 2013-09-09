# IRB.CurrentContext.last_value is same as _
# but _ doesn't work as a default argument
def c(str=IRB.CurrentContext.last_value)
  IO.popen('pbcopy', 'w'){ |f| f << str.to_s }
end
