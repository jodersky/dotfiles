(use-package spotify
  :config
  (advice-add 'spotify-previous :after #'spotify-current) ; print current song
  (advice-add 'spotify-next :after #'spotify-current) ; print current song
  :bind
  (("M-s SPC" . spotify-playpause)
   ("M-s p" . spotify-previous)
   ("M-s n" . spotify-next)))
