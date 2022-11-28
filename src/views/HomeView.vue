<script setup>
  import BasicTable from '@/components/BasicTable.vue'

  const rows = [
    {key: '001', first: 'Mark', last: 'Otto', status: '<span class="badge text-bg-success">Validée</span>'},
    {key: '002', first: 'Jacque', last: 'Latu', status: '<span class="badge text-bg-success">Validée</span>'},
    {key: '003', first: 'Laura', last: 'Paulo', status: '<span class="badge text-bg-warning">En attente</span>'},
    {key: '004', first: 'Patrick', last: 'Moop', status: '<span class="badge text-bg-warning">En attente</span>'},
    {key: '005', first: 'Nick', last: 'Tuto', status: '<span class="badge text-bg-success">Validée</span>'},
    {key: '006', first: 'Kick', last: 'Polm', status: '<span class="badge text-bg-danger">Refusée</span>'},
    {key: '007', first: 'Auto', last: 'Laune', status: '<span class="badge text-bg-success">Validée</span>'},
    {key: '008', first: 'Luna', last: 'Aire', status: '<span class="badge text-bg-success">Validée</span>'},
    {key: '009', first: 'Martine', last: 'Lille', status: '<span class="badge text-bg-warning">En attente</span>'},
    {key: '010', first: 'Jean', last: 'Val', status: '<span class="badge text-bg-success">Validée</span>'},
    {key: '011', first: 'Valentin', last: 'Kaque', status: '<span class="badge text-bg-success">Validée</span>'},
    {key: '012', first: 'Hasma', last: 'Maud', status: '<span class="badge text-bg-success">Validée</span>'},
  ];

  const columns = [
    {name: 'key', label: '#'},
    {name: 'last', label: 'Last'},
    {name: 'first', label: 'First'},
    {name: 'status', label: 'Statut'}
  ];
</script>

<template>
  <div class="about">
    <div class="h1"><span class="text-primary">B</span>asicTable</div>
    <hr>
    <BasicTable :rows='rows' :columns='columns' :rowsPerPage="10" />
  </div>
</template>