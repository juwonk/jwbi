# ggplot2 
# add linear regression model

lm_eqn <- function(x,y,df){
  m <- lm(y ~ x, df);
  eq <- substitute(italic(y) == a + b %.% italic(x)*","~~italic(r)^2~"="~r2, 
                   list(a = format(coef(m)[1], digits = 2), 
                        b = format(coef(m)[2], digits = 2), 
                        r2 = format(summary(m)$r.squared, digits = 3)))
  as.character(as.expression(eq));                 
}

ggplot(GBM_symbol_t, aes(x = KDM4C, y=GBM_symbol_t[,genes2[1]])) +
  geom_point() +
  geom_smooth(method = 'lm')+
  geom_text(x = 250, y = 7500, label = lm_eqn(GBM_symbol_t[,"KDM4C"],
                                              GBM_symbol_t[,genes2[1]],
                                              GBM_symbol_t), parse = TRUE)