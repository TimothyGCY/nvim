return {
  {
    'tzachar/cmp-tabnine',
    --build = './install.sh', -- for Mac or Linux
    build = 'powershell ./install.ps1',
    dependencies = 'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    config = function()
      local tabnine = require('cmp_tabnine.config')
      -- local token = 'eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJhdWQiOiJodHRwczovL2lkZW50aXR5dG9vbGtpdC5nb29nbGVhcGlzLmNvbS9nb29nbGUuaWRlbnRpdHkuaWRlbnRpdHl0b29sa2l0LnYxLklkZW50aXR5VG9vbGtpdCIsImlhdCI6MTcwNTEzNTE3MiwiZXhwIjoxNzA1MTM4NzcyLCJpc3MiOiJmaXJlYmFzZS1hZG1pbnNkay02cjM0eUB0YWJuaW5lLWF1dGgtMzQwMDE1LmlhbS5nc2VydmljZWFjY291bnQuY29tIiwic3ViIjoiZmlyZWJhc2UtYWRtaW5zZGstNnIzNHlAdGFibmluZS1hdXRoLTM0MDAxNS5pYW0uZ3NlcnZpY2VhY2NvdW50LmNvbSIsInVpZCI6IkUxellYR2xwbTlkQW1MU0hLOGdaNFR4amtJQjIifQ.EUBH3irydTO_qXs8SzfH_CAZayQN70_t84Mn7BOYXItt_Fh-fcbWhswikoVB1zOAcovFJ1R0TJInNmqbRbFKEmTJ2U-_vXr05id0yRbIi_dUtNmlUDxQf6Bw_NRilEIri04143xCs9A7r25KHLj-X4gPN_yv-XZEI3X7Js57FKzB2juFus70bgQ-0r03aIc1M6dKXkenFqjUKapiJbSqUWPlqh8pioCt98BfhHv4BH4gBX5AWk_m2z39-hM01uiL4kl-phCZEU32VN-MJsRJh2CJ5kpAjk-EUb4EozXaievAZ06ELrRsHF5jKMBNRX7DUjJwTbNOJqwyT--saFjGJAm'
      tabnine:setup({
        max_lines = 1000,
        max_num_results = 20,
        sort = true,
      })
    end
  }
}
