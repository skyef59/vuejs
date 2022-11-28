<script setup>
    import { BIconArrowDownSquare, BIconArrowUpSquare } from 'bootstrap-icons-vue';
    import { ref } from "vue";

    const props = defineProps({
        columns: {type: Array, default: []},
        rows: {type: Array, default: []},
        rowsPerPage: {type: Number, default: 5}
    });

    const currentPage = ref(1);
    const rowsPerPage = ref(props.rowsPerPage);
    const sortBy = ref('key');
    const sortDirection = ref('asc');

    const handleChangePage = (page) => {
        currentPage.value = page;
    };

    const handleChangeSort = (column) => {
        sortDirection.value = column == sortBy.value && sortDirection.value == 'asc' ? 'desc' : 'asc';
        sortBy.value = column;
    };

    const resolveRow = () => {
        let rows = props.rows;
        let page = currentPage.value;
        let currentSortBy = sortBy.value;
        let sortFunctionResult = sortDirection.value == 'asc' ? {first: 1, second: -1} : {first: -1, second: 1};

        //Trie le tableau en fonction de la colonne choisie
        rows.sort((a,b) => (a[currentSortBy] > b[currentSortBy]) ? sortFunctionResult.first : (
            (b[currentSortBy] > a[currentSortBy]) ? sortFunctionResult.second : 0
        ));

        //Récupére les lignes de la page
        return rows.slice((page - 1) * rowsPerPage.value, page * rowsPerPage.value);
    }
</script>

<template>

<div class="dropdown" v-if="props.rows.length > 5">
    <button class="btn btn-secondary btn-sm dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
        Lignes par page <b>{{rowsPerPage}}</b>
    </button>
    <ul class="dropdown-menu">
        <li @click="rowsPerPage = 5; handleChangePage(1)"><a :class="'dropdown-item ' + (rowsPerPage == 5 && 'active')" href="#">5</a></li>
        <li @click="rowsPerPage = 10; handleChangePage(1)" v-if="props.rows.length > 5"><a :class="'dropdown-item ' + (rowsPerPage == 10 && 'active')" href="#">10</a></li>
        <li @click="rowsPerPage = 20; handleChangePage(1)" v-if="props.rows.length > 10"><a :class="'dropdown-item ' + (rowsPerPage == 20 && 'active')" href="#">20</a></li>
    </ul>
</div>

<table class="table table-striped table-hover border-bottom border-top mt-2">
    <thead>
        <tr>
            <th 
                v-for="column in props.columns" :key="column.name"
                scope="col" 
                @click="handleChangeSort(column.name)" 
                class="cursor"
            >
                {{ column.label }}
                <span class="h5 text-primary">
                    <BIconArrowDownSquare v-if="sortBy == column.name && sortDirection == 'asc'" />
                    <BIconArrowUpSquare v-if="sortBy == column.name && sortDirection == 'desc'" />
                </span>
            </th>
        </tr>
    </thead>
    <tbody>
        <tr v-for="row in resolveRow()" :key="row">
            <td 
                v-for="column in props.columns" 
                :key="column.name"
            >
                <div v-html="row[column.name]"></div>
            </td>
        </tr>
    </tbody>
</table>

<nav v-if="Math.ceil(props.rows.length / rowsPerPage) > 1" aria-label="..." class="d-flex justify-content-center">
    <ul class="pagination pagination-sm">
        <li 
            v-for="n in Math.ceil(props.rows.length / rowsPerPage)" 
            :class="'page-item ' + (currentPage == n ? ' active' : '')" 
            @click="handleChangePage(n)"
        >
            <a class="page-link" href="#">{{ n }}</a>
        </li>
    </ul>
</nav>
</template>

<style>
    .cursor {
        cursor: pointer;
    }
</style>